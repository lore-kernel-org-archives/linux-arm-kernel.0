From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Fri, 29 May 2015 12:04:21 +0200
Subject: [PATCH 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
In-Reply-To: <1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20150529120421.754fd6ab@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 May 2015 13:35:53 +0530, Bhuvanchandra DV wrote:
> The LPUART does not provide manual control of RTS/CTS signals,
> those can only be controlled by the hardware directly. Therefore
> manual control of those signals through mctrl can not be provided.
> The current implementation enables/disables the automatic control,
> which is not what mctrl should do, hence remove the incorrect
> implementation.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>

Now that the functions do nothing there is probably no point in keeping
separate lpuart/lpuart32 variants.
