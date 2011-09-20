From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 20 Sep 2011 14:24:28 +0300
Subject: [PATCH 1/3] include: fb: Add definiton for window positioning
	structure
In-Reply-To: <1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <20110920112427.GB19695@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ajay,

On Tue, Sep 20, 2011 at 11:30:39AM -0400, Ajay Kumar wrote:
> This patch adds a data structure definiton to hold framebuffer windows/planes.
> An ioctl number is also added to provide user access
> to change window position dynamically.

[snip]

> +/* Window overlaying */
> +struct fb_overlay_win_pos {
> +	__u32 win_pos_x;	/* x-offset from LCD(0,0) where window starts */
> +	__u32 win_pos_y;	/* y-offset from LCD(0,0) where window starts */
> +};

Why not allow negative offsets where the left or upper part of the framebuffer 
is hidden?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
