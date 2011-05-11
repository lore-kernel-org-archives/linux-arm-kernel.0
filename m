From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 May 2011 15:07:05 +0200
Subject: [PATCH v2 1/2] pxamci: remove the ifdef CONFIG_REGULATOR
In-Reply-To: <1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
References: <20110510203629.GB8726@opensource.wolfsonmicro.com>
	<1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20110511130705.GA12469@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 12:19:05PM +0200, Antonio Ospite wrote:
> Don't wrap regulator_get() inside an ifdef CONFIG_REGULATOR anymore, as
> now it degenerates and returns NULL when the regulator framework is
> disabled (since commit be1a50d: regulator: Let drivers know when they
> use the stub API); and use IS_ERR_OR_NULL() to handle the stub function 
> correctly.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
