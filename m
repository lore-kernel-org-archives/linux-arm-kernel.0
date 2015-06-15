From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Mon, 15 Jun 2015 10:29:17 -0400
Subject: [PATCH v5 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <20150609213338.GD5720@breakpoint.cc> (Sebastian Andrzej
 Siewior's message of "Tue, 9 Jun 2015 23:33:38 +0200")
References: <1433584416-29607-1-git-send-email-stefan@agner.ch>
 <1433584416-29607-2-git-send-email-stefan@agner.ch>
 <20150609213338.GD5720@breakpoint.cc>
Message-ID: <BLU436-SMTP1380BAD5F776944D62A9148B8B80@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On  9 Jun 2015, sebastian at breakpoint.cc wrote:

> On 2015-06-06 11:53:31 [+0200], Stefan Agner wrote:

>> +static const struct of_device_id vf610_nfc_dt_ids[] = {
>> +	{ .compatible = "fsl,vf610-nfc" },
>> +	{ .compatible = "fsl,mpc5125-nfc" },

> I advise against a "fsl,mpc5125-nfc" binding. First of all it is the
> same as the previous one. Second of all it was not tested at all on
> the SoC it suggests to work. Plus the chip select function has a
> comment hat it won't work on MPC5125. So it really makes no sense to
> add it here.

Someone has used a version of the driver on the PowerPC.  I don't have
access to his email address now.  Anyways, the chipselect code is
different on the PowerPC versions of the controller afair.  So if some
external code sets up the chipselect for a single chip, then things are
fine.

Both the PowerPC and ARM support DT/OF, but you can never actually run
either version as the code must be compiled for either assembler.  So I
am not quite sure that this was the correct way to go anyways...  So I
agree with your conclusion we can remove that binding.

Regards,
Bill.
