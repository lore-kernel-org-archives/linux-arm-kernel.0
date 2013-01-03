From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 03 Jan 2013 11:32:32 +0000
Subject: [PATCH v6] ARM: mtd: nand: davinci: add OF support for davinci
 nand controller
In-Reply-To: <50E56AED.1000509@mvista.com>
References: <1343632944-25971-1-git-send-email-hs@denx.de>
 <50E48DFD.2030908@mvista.com> <50E52D26.9010004@denx.de>
 <50E56AED.1000509@mvista.com>
Message-ID: <1357212752.16197.127.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-03 at 15:26 +0400, Sergei Shtylyov wrote:
> >>> +#if defined(CONFIG_OF)
> >>> +static const struct of_device_id davinci_nand_of_match[] = {
> >>> +    {.compatible = "ti,davinci-nand", },
> >>> +    {},
> >>> +}
> >>> +MODULE_DEVICE_TABLE(of, davinci_nand_of_match);
> 
> > Hmm.. maybe this crept in later after I sent the patches? They were
> > pending for a while ... I compiled it just yet again (based on my
> > tree when I posted this patch based on commit:
> 
>     I've just checked the archives: every patch version you posted had ';' 
> after '}' missing.

If it was built-in, rather than as a module, then MODULE_DEVICE_TABLE(?)
expands to nothing, and the structure gets to use the semicolon from the
end of that line.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/589e7477/attachment-0001.bin>
