From: cjb@laptop.org (Chris Ball)
Date: Mon, 24 Oct 2011 05:27:44 -0400
Subject: [PATCH 0/2] MMC: disable multiblock reads on controllers that
	don't support them
In-Reply-To: <20111006205002.7083.94088.stgit@dusk> (Paul Walmsley's message
	of "Thu, 06 Oct 2011 14:50:30 -0600")
References: <20111006205002.7083.94088.stgit@dusk>
Message-ID: <m2wrbu4u3z.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Oct 06 2011, Paul Walmsley wrote:
> Some MMC controller instances integrated on older OMAP34xx/35xx chips
> don't work correctly with multiple-block reads, due to a hardware bug.
> This series fixes the problem by adding an MMC capability flag for this
> case and making the appropriate changes to the MMC core code and OMAP HSMMC
> driver to support this.
>
> Once this series is merged, a subsequent patch will be needed by us OMAP
> folks to pass the appropriate device data via hwmod - this will be posted
> separately.

Thanks, both pushed to mmc-next for 3.2.

We've run out of MMC caps nad moved onto CAPS2, so I modified these patches
to define and test MMC_CAP2_NO_MULTI_READ instead of MMC_CAP_NO_MULTI_READ:

  http://dev.laptop.org/git/users/cjb/mmc/commit/?h=mmc-next&id=a4b35b6acf2e9edc52132d34015f0a90b02e2df2
  http://dev.laptop.org/git/users/cjb/mmc/commit/?h=mmc-next&id=6d621423128909f09072835445ce36dd357a758a

(This shouldn't affect your hwmod patch, since that just uses an
OMAP-internal flag.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
