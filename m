From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Sep 2014 09:56:02 +0200
Subject: [PATCH v2 1/3] pinctrl: at91: add drive strength configuration
In-Reply-To: <CACRpkdagLTaumFH_rzYzvW1+TSwwN+ABBdCeH9qrLwXpyu0dJg@mail.gmail.com>
References: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
 <CACRpkdagLTaumFH_rzYzvW1+TSwwN+ABBdCeH9qrLwXpyu0dJg@mail.gmail.com>
Message-ID: <54096C92.7020205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 09:33, Linus Walleij :
> On Sun, Aug 24, 2014 at 5:12 AM, Marek Roszko <mark.roszko@gmail.com> wrote:
> 
>> The SAMA5 and SAM9x5 series both have drive strength options for the PIOs. This
>> patch adds the ability to set one of three hardware options for drive strengths of low,
>> medium or high for the each pin. The actual current output of the chip based on the setting
>> is defined in the datasheets and varies per pins separate from banks and with supply voltage.
>>
>> This patch adds three new dt-bindings that allow setting the strength when configuring
>> pins. By default, no change will be made to the drive strength of a pin from its reset value.
>> Due to the difference between the register addresses of the SAMA5 and SAM9x5 series, a new
>> sama5d3-pinctrl id was added.
>>
>> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
>>
>> ---
>> changes from v1:
>> rebased to latest pinctrl
>> added requested comments
>> fix oversight in shift logic(off by 1)
> 
> Tentatively applied this patch so we get some rotation in linux-next.

After reading the comments made back in January during first submission
of this feature, it seems that there was a consensus on this patch series.
After a quick look at the new version, the comments and needed
documentation has been added: Thanks Marek!

So, if it can help, you have my:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

On the whole series. I will certainly take the AT91 compatible string
addition with my tree as well (patch 2/3).

Thanks to both of you, bye,
-- 
Nicolas Ferre
