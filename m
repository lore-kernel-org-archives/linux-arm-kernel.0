From: ajaynumb@gmail.com (Ajay kumar)
Date: Tue, 20 Sep 2011 20:56:57 +0530
Subject: [PATCH 1/3] include: fb: Add definiton for window positioning
	structure
In-Reply-To: <20110920112427.GB19695@sapphire.tkos.co.il>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<20110920112427.GB19695@sapphire.tkos.co.il>
Message-ID: <CAEC9eQOpwfmRfcxHoiA00xX0a=dxXj1xJDpW14DozGXKXPJ3Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, Sep 20, 2011 at 4:54 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Ajay,
>
> On Tue, Sep 20, 2011 at 11:30:39AM -0400, Ajay Kumar wrote:
>> This patch adds a data structure definiton to hold framebuffer windows/planes.
>> An ioctl number is also added to provide user access
>> to change window position dynamically.
>
> [snip]
>
>> +/* Window overlaying */
>> +struct fb_overlay_win_pos {
>> + ? ? __u32 win_pos_x; ? ? ? ?/* x-offset from LCD(0,0) where window starts */
>> + ? ? __u32 win_pos_y; ? ? ? ?/* y-offset from LCD(0,0) where window starts */
>> +};
>
> Why not allow negative offsets where the left or upper part of the framebuffer
> is hidden?

Thanks for pointing it out. Are there drivers which place the overlay
windows such that some part of the window is hidden from being
displayed on the screen?

> baruch
>
> --
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~. .~ ? Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
> ? - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

Ajay
