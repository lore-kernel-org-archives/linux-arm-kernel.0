From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 12:22:12 -0600
Subject: [RFC PATCH] ARM: bcm2835: convert to multi-platform
In-Reply-To: <20130312080206.GI18574@S2101-09.ap.freescale.net>
References: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
 <20130312080206.GI18574@S2101-09.ap.freescale.net>
Message-ID: <513F7254.1060301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 02:02 AM, Shawn Guo wrote:
> On Mon, Mar 11, 2013 at 10:59:59PM -0600, Stephen Warren wrote:
>> This allows BCM2835 be included in a kernel build that supports multiple
>> SoCs at once, which is useful for distro kernels.
>>
>> This change:
>> * Moves bcm2835's debug-macro.S into ARM's include/debug/, and hooks it
>>   into the relevant menu.
>> * Moves bcm2835's Kconfig into its own directory, as seems typical for
>>   multi-platform conversions.
>> * Removes bcm2835_soc.h, and moves the content to the files where it was
>>   used; just one usage per define.
>> * Deletes some headers and Makefile.boot that aren't needed now that we
>>   support multi-platform.
>>
>> TO DO:
>> * It'd be nice to restore uncompress.h. I need to take a look at Shawn
>>   Guo's patches related to this, and presumably rebase this on top of
>>   them.
> 
> You do not need to restore uncompress.h, and from what I've seen,
> with my patches in place, uncompress debug will probably just work
> on BCM2835 out of box (you need to have DEBUG_LL selected for BCM2835).

Should the usual "Uncompressing kernel" message show up automatically
then? I don't think it did, which is why I mentioned that "TO DO". I
almost always run with DEBUG_LL enabled and earlyprintk in the kernel
command-line, but I should double-check I didn't accidentally drop it
when testing this patch.
