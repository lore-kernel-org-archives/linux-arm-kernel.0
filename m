From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 12 Jul 2014 17:27:59 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <1405086308-1461192-4-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
Message-ID: <53C153FF.4090705@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2014 03:45 PM, Arnd Bergmann wrote:
> As a prerequisite for moving s3c64xx into multiplatform configurations,
> we need to change the smartq audio driver to stop using hardcoded
> gpio numbers from the header file, and instead pass the gpio data
> through platform_data.

This should be using the gpiod API. The gpiod API allows you to pass the GPIOs 
without having to add a platform_data struct.

- Lars
