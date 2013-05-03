From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 3 May 2013 10:52:34 +1000
Subject: [GIT PULL] Removal of GENERIC_GPIO
In-Reply-To: <51823DDA.7010103@nvidia.com>
References: <51823DDA.7010103@nvidia.com>
Message-ID: <20130503105234.6e9c8aa5ed2784bbe084caa8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Thu, 2 May 2013 19:20:10 +0900 Alex Courbot <acourbot@nvidia.com> wrote:
>
> Here is the pull request for the GENERIC_GPIO removal. It is almost 
> certain that a few fixups will be necessary - while I don't have precise 
> patches, the following steps should ensure the state of the code is clean:
> 
> * "git grep CONFIG_GENERIC_GPIO" should return 0 hits. Matches should be 
> replaced with CONFIG_GPIOLIB
> * "git grep '\bGENERIC_GPIO\b'" should return 1 hit in the Chinese 
> documentation. Selectors of GENERIC_GPIO should be turned into selectors 
> of GPIOLIB, while definitions of the option in architecture code should 
> be deleted.
> 
> Please let me know if there is something more I can do to ease your task.
> 
> Thanks,
> Alex.
> 
> The following changes since commit 10b38669d64c757cfd927e3820292c580ed70aae:
> 
>    Merge tag 'for-linus-v3.9-rc4' of git://oss.sgi.com/xfs/xfs 
> (2013-03-19 15:17:40 -0700)
> 
> are available in the git repository at:
> 
>    git://github.com/Gnurou/linux.git for_grant
> 
> for you to fetch changes up to f4c54050640e7afa4749875cf9b900d42db361c0:
> 
>    gpio: update gpio Chinese documentation (2013-04-16 18:47:22 +0900)

I currently have 3 merge fix patches for the gen-cpio tree:

gen-gpio: GPIOLIB merge fix up
merge fix for Convert selectors of GENERIC_GPIO to GPIOLIB
merge fix 2 for Convert selectors of GENERIC_GPIO to GPIOLIB

I have attached them.  All three are now applicable to Linus' tree.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gen-gpio-GPIOLIB-merge-fix-up.patch
Type: text/x-diff
Size: 810 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/6f943365/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-merge-fix-for-Convert-selectors-of-GENERIC_GPIO-to-G.patch
Type: text/x-diff
Size: 769 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/6f943365/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-merge-fix-2-for-Convert-selectors-of-GENERIC_GPIO-to.patch
Type: text/x-diff
Size: 875 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/6f943365/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/6f943365/attachment.sig>
