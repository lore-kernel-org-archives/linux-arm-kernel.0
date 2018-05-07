From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 7 May 2018 13:40:51 +0900
Subject: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
In-Reply-To: <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
 <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
Message-ID: <20180507044050.GC11326@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 06:46:04PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 25/04/18 07:26, AKASHI Takahiro wrote:
> > Change this function from static to global so that arm64 can implement
> > its own arch_kimage_file_post_load_cleanup() later using
> > kexec_image_post_load_cleanup_default().
> 
> Do we need to call kexec_image_post_load_cleanup_default()? All it does is call
> the image-type fops->cleanup(), which you don't implement in this series.
> 
> Is this just-in-case someone adds cleanup() later and is surprised only the
> arch-level helper is called?

Yes, we want not to miss two possibilities:
- some common clean-up code is added to kexec_image_post_load_cleanup_default()
- some format(i.e. Image)-specific clean-up code is added to fops->cleanup()

-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James
