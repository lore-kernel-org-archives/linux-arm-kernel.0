From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 23:30:44 +0100
Subject: [PATCH V3 02/26] coresight: etm3x: moving sysFS entries to
 dedicated file
In-Reply-To: <1447280296-19147-3-git-send-email-mathieu.poirier@linaro.org>
References: <1447280296-19147-1-git-send-email-mathieu.poirier@linaro.org>
 <1447280296-19147-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <4446604.iDni9pkfpc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 November 2015 15:17:52 Mathieu Poirier wrote:
> SysFS entries are big enough to justify their own file.
> As such moving all sysFS related declarations to a dedicated
> location.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/Makefile               |    3 +-
>  drivers/hwtracing/coresight/coresight-etm.h        |    4 +
>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 1218 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 1234 +-------------------
> 

You are adding a lot of interfaces here, make sure that each one is documented
in Documentation/ABI/.

Your patch series doesn't add anything here, are you just using an existing
ABI?

	Arnd
