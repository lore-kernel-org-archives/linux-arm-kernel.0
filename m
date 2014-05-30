From: satish.patel@ti.com (Satish Patel)
Date: Fri, 30 May 2014 09:38:20 +0530
Subject: [PATCH v3 3/5] char: ti-usim: Add driver for USIM module on AM43xx
In-Reply-To: <20140529155349.GD32214@kroah.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
 <1401267437-22489-4-git-send-email-satish.patel@ti.com>
 <CAL_JsqKs=a8GRJRmNE-oxU4imHqnb5szv+Km-wv3KuN0d6Bxkg@mail.gmail.com>
 <53870671.6080601@ti.com> <20140529155349.GD32214@kroah.com>
Message-ID: <53880434.7080002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/29/2014 9:23 PM, Greg Kroah-Hartman wrote:
> On Thu, May 29, 2014 at 03:35:37PM +0530, Satish Patel wrote:
>>>> +enum usim_card_mode {
>>>> +       USIM_CARD_MODE_ASYNC = 0,       /* asynchronous mode */
>>>> +       USIM_CARD_MODE_SYNC_TYPE1,      /* synchronous mode: Type 1 */
>>>> +       USIM_CARD_MODE_SYNC_TYPE2,      /* synchronous mode: Type 2 */
>>>> +       USIM_CARD_MODE_SYNC_OTHER,      /* Any other synchronous type */
>>>> +};
>>>> +struct usim_data {
>>>> +       int slot;
>>>> +       int rxexplen;
>>>> +       int txlen;
>>>> +       unsigned char apdu[256];
>>>> +};
>
> You need to use the proper variable types for a structure that is going
> to cross the user/kernel boundry in an ioctl :(
Do you mean to use __u32 instead int ? make use of types defined in 
types.h ? if yes, I will make that change :). Thanks for pointing out.
>
