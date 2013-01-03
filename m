From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 03 Jan 2013 15:39:08 +0400
Subject: [PATCH v6] ARM: mtd: nand: davinci: add OF support for davinci
 nand controller
In-Reply-To: <1357212752.16197.127.camel@shinybook.infradead.org>
References: <1343632944-25971-1-git-send-email-hs@denx.de>
 <50E48DFD.2030908@mvista.com> <50E52D26.9010004@denx.de>
 <50E56AED.1000509@mvista.com>
 <1357212752.16197.127.camel@shinybook.infradead.org>
Message-ID: <50E56DDC.8060804@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03-01-2013 15:32, David Woodhouse wrote:

>>>>> +#if defined(CONFIG_OF)
>>>>> +static const struct of_device_id davinci_nand_of_match[] = {
>>>>> +    {.compatible = "ti,davinci-nand", },
>>>>> +    {},
>>>>> +}
>>>>> +MODULE_DEVICE_TABLE(of, davinci_nand_of_match);

>>> Hmm.. maybe this crept in later after I sent the patches? They were
>>> pending for a while ... I compiled it just yet again (based on my
>>> tree when I posted this patch based on commit:

>>      I've just checked the archives: every patch version you posted had ';'
>> after '}' missing.

> If it was built-in, rather than as a module, then MODULE_DEVICE_TABLE(?)
> expands to nothing, and the structure gets to use the semicolon from the
> end of that line.

    Ah, that explains it: 'davinci_all_defconfig' has 
CONFIG_MTD_NAND_DAVINCI=m, so that's how the error got triggered at last. 
Probably worth adding this explanation to the changelog, how do you think?

WBR, Sergei
