From: uwe@kleine-koenig.org (=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=)
Date: Thu, 12 Jan 2017 14:18:46 +0100
Subject: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
In-Reply-To: <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <9f48e2a8-e1e0-e3db-af48-12297f8521f2@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 11:02 PM, Bjorn Helgaas wrote:
> Hi Uwe,
> 
> On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
>> ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
>> is enabled:
>>
>> [...]
> We have several open issues related to ASPM:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=102311 ASPM: ASMEDA asm1062 not working
>   https://bugzilla.kernel.org/show_bug.cgi?id=187731 Null pointer dereference in ASPM
>   https://bugzilla.kernel.org/show_bug.cgi?id=189951 Enabling ASPM causes NIC performance issue
>   https://bugzilla.kernel.org/show_bug.cgi?id=60111 NULL pointer deref in ASPM alloc_pcie_link_state()
> 
> I don't recognize yours as being one of these.  Can you open a new
> issue and attach the complete dmesg log and "lspci -vv" output?

Done: https://bugzilla.kernel.org/show_bug.cgi?id=192441

> Is this a regression?

As written in the bug report this also happens on 4.7.

Best regards
Uwe


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/d9f681f1/attachment.sig>
