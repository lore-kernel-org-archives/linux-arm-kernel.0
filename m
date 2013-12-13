From: M.Mann@arkona-technologies.de (Matthias Mann)
Date: Fri, 13 Dec 2013 09:42:35 +0100
Subject: [PATCH] pci: designware: fix missing msi irqs
In-Reply-To: <52AA0EB2.2070701@arkona-technologies.de>
References: <20131212182903.409515738@gmail.com>
 <52AA0EB2.2070701@arkona-technologies.de>
Message-ID: <52AAC87B.6000007@arkona-technologies.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.12.2013 20:29, schrieb Matthias Mann:
> Am 12.12.2013 19:29, schrieb Harro Haan:
>> The interrupts were cleared after the irq handler was called.
>> This means that new interrupts that occur after the handler handled
>> the previous irq but before the interrupt is cleared will be missed.
>
> I discovered the same issue today. I'll test that patch tomorrow.
>
I tested this patch on our custom i.MX6 board with an Altera FPGA as PCIe
device and it fixed the missed MSI interrupts.

Tested-by:  Matthias Mann <m.mann@arkona-technologies.de>

Regards
Matthias Mann

-- 

Matthias Mann
Research & Development

Phone: 	+49 (0) 6155 7802883
Fax: 	+49 (0) 6155 7802880
Email: 	M.Mann at arkona-technologies.de 
<mailto:M.Mann@arkona-technologies.de>
Web: 	www.arkona-technologies.de <http://www.arkona-technologies.de>

arkona technologies GmbH
Im Leuschnerpark 4
64347 Griesheim
Germany

Amtsgericht / Commercial Register of Darmstadt, HRB 90080
USt-ID: DE273794666
Steuernummer / Tax-ID: 007 / 228 / 19331
Gesch?ftsf?hrung / Managing Director: Rainer Sturm

This e-mail may contain confidential and/or privileged information. If you are
not the intended recipient (or have received this e-mail in error) please notify
the sender immediately and delete this message and any attachments from your
system. Any unauthorised copying, disclosure or distribution of the material in
this e-mail is strictly forbidden.

We cannot accept any responsibility for the accuracy or completeness of this
message as it has been transmitted over a public network. If, despite our use of
anti-virus software, a virus enters your systems in connection with the sending
of the e-mail, you may not hold us liable for any damages that may possibly
arise in that connection. We will accept liability which by law we cannot exclude.
