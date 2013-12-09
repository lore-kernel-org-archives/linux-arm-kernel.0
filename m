From: zonque@gmail.com (Daniel Mack)
Date: Mon, 09 Dec 2013 10:04:32 +0100
Subject: [PATCH 5/9] ARM: dts: provide DMA config to pxamci
In-Reply-To: <201312090233.58592.arnd@arndb.de>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-6-git-send-email-ynvich@gmail.com>
 <201312090233.58592.arnd@arndb.de>
Message-ID: <52A587A0.1050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 02:33 AM, Arnd Bergmann wrote:
> On Sunday 08 December 2013, Sergei Ianovich wrote:
>> Non-dts implementation supply required DMA channel numbers as
>> IORESOURCE_DMA. However, there is was no way to get them from
>> device tree.
> 
> I just wrote a lengthy reply to this email to explain in what ways
> you got it wrong, but then I saw that Daniel has already done all
> the work in the right way in August, so nevermind that.
> 
> It hasn't made it upstream yet, but see http://list-archives.org/2013/08/07/linux-mtd-lists-infradead-org/patch-00-20-arm-pxa-move-core-and-drivers-to-dmaengine/f/3444199144
> for how it's done. Maybe Daniel can comment on the status of his
> patches.

I recently rebased all my patches on top of 3.13-rc3, and will resend in
couple of days.

The real problem here is that by reworking the DMA related PXA bits, all
drivers have to be changed at once, and a gradual transition seems
impossible. For that, I was asking for help in areas where I don't have
any hardware to test my patches on, but unfortunately, nobody got back
to me yet.

In particular, the pxa camera driver is something Robert (cc) wanted to
have a look at. Robert, any updates on this?


Anyway, I'll have to clean up some details and will resend my patches
very soon.


Thanks,
Daniel
