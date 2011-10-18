From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 18 Oct 2011 14:54:47 +0200
Subject: [PATCH] ARM: mxs: Add initial support for Bluegiga APX4
	Development Kit
In-Reply-To: <4E9D481D.2070905@bluegiga.com>
References: <1318838916-8529-1-git-send-email-lauri.hintsala@bluegiga.com>
	<20111017094434.GA21504@pengutronix.de>
	<20111017103958.GD7761@tarshish> <4E9D2E9A.8000600@bluegiga.com>
	<20111018075843.GG7761@tarshish> <4E9D481D.2070905@bluegiga.com>
Message-ID: <20111018125447.GA2345@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lauri,

On Tue, Oct 18, 2011 at 12:34:21PM +0300, Lauri Hintsala wrote:
> On 10/18/2011 10:58 AM, Baruch Siach wrote:
> >u-boot can pass any string you like to the kernel. Just do
> 
> Yes I know I can pass any string I like.
> 
> 
> >setenv bootargs "$bootargs fec.macaddr=0x00,0x04,0x9f,0x01,0x30,0xe0"
> >
> >at the u-boot prompt, or in a script.
> 
> ethaddr variable of uboot is taking mac addr in colon separated form
> (e.g. "00:04.9f:01:30:e0") and it is not very useful to have mac
> address in two different form in uboot envs.

Makes sense. The code doing the array module parameters is in 
kernel/params.c:param_array(). It seems that teaching this routine to parse 
the common MAC notation is not very hard. This IMO is a better solution than 
adding another MAC parser for a new top-level kernel parameter.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
