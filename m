From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 May 2014 13:22:35 +0300
Subject: [PATCH] s3cmci: port DMA code to dmaengine API
In-Reply-To: <4667090.Oyf6jd3Lyk@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
 <7633675.1cAc12AFAY@wuerfel>
 <CA+E=qVeG8bXowBvdhKpVSYSL08n6ZUVG2LkjhPwjBnbv+egNLw@mail.gmail.com>
 <4667090.Oyf6jd3Lyk@wuerfel>
Message-ID: <CA+E=qVch0K+raN4dkPK6XzXqOQc4t433UyCJ2Qnc2uymgTq7cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, May 19, 2014 at 10:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> For this driver, you don't have to go that far, as long as it's
> ensure that the pointer to the filter function is available to
> the driver, i.e. you can't have a built-in s3mci driver when the
> dmaengine driver is a loadable module.

OK, so I guess I need to add explicit dependency on
CONFIG_S3C24XX_DMAC for s3cmci driver.

Btw, I didn't understand if it's acceptable to pass DMA channel number
through DMA resource for non-DT case or not?

Regards
Vasily
