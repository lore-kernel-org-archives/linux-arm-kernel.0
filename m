From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2009 10:09:42 +0200
Subject: [PATCH 5/6] mx31moboard: camera support
In-Reply-To: <4ADC96A9.3090403@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-4-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-5-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
	<Pine.LNX.4.64.0910162307160.26130@axis700.grange>
	<4ADC96A9.3090403@epfl.ch>
Message-ID: <20091020080941.GN8818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 06:41:13PM +0200, Valentin Longchamp wrote:
> Hi Guennadi,
>
> Guennadi Liakhovetski wrote:
>> Hi
>>
>> On Thu, 15 Oct 2009, Valentin Longchamp wrote:
>>
>>> We have two mt9t031 cameras that have a muxed bus on the robot.
>>> We can control which one we are using with gpio outputs. This
>>> currently is not optimal
>>
>> So, what prevents you from registering two platform devices for your 
>> two cameras? Is there a problem with that?
>
> The lack of time until now to do it properly. I sent those patches as  
> initial RFC (and by the way thanks for your comment).
>
> I would like to have one video interface only and that I can switch  
> between the two physical camera using a quite simple system call. Would  
> that be compatible with registering the two platform devices ?

Wouldn't it be better to have /dev/video[01] for two cameras? How do
keep the registers synchron between both cameras otherwise?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
