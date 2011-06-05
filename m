From: avinashhm@ti.com (Avinash.H.M.)
Date: Sun, 5 Jun 2011 14:19:15 +0530
Subject: [PATCH v4] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
In-Reply-To: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
References: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
Message-ID: <20110605084915.GA2887@avinash-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 09:16:24PM +0530, Avinash.H.M wrote:
> The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> special sequence to reset the module. The sequence is
>  - Disable the I2C.
>  - Write to SOFTRESET bit.
>  - Enable the I2C.
>  - Poll on the RESETDONE bit.
> The sequence is implemented as a function and the i2c_class is updated with
> the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> which triggers the softreset by writing into sysconfig register. On following
> this sequence, i2c module resets properly and timeouts are not seen.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> ---

Hi Kevin, Paul ,

Ping .. could you please review this.

thanks ,

- Avinash
