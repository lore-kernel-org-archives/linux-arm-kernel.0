From: george.cherian@ti.com (George Cherian)
Date: Tue, 29 Apr 2014 13:57:34 +0530
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <535F5D6B.6090802@linutronix.de>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
 <535F5BA5.6000903@ti.com> <535F5D6B.6090802@linutronix.de>
Message-ID: <535F6276.4050601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 4/29/2014 1:36 PM, Sebastian Andrzej Siewior wrote:
> On 04/29/2014 09:58 AM, George Cherian wrote:
>>>> This is easily fixed by moving the node at the beggining of the child
>>>> list,
>>>> so it's probed first.
>> This will give issues on module removal.
>> Since we use device_for_each_child in remove patch, it will try to
>> remove cppi dma controller, while the channel
>> is still in use by musb node.
> Isn't this currently disabled because it blew up in the phy code?
Yes. So how if the dt  looks like this

usb {
         ....
         ....
         usb_ctrl_mod {
             ....
             ....
         };
         usb0 {
             ....
             ....
         };
         usb0_phy {
             ....
             ....
         };
         usb1 {
             ....
             ....
         };
         usb1_phy {
             ....
             ....
         };

         cppi41dma {
             ....
             ....
         };
};
>
> Sebastian
>


-- 
-George
