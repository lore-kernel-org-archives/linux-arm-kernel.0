From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 9 Oct 2018 17:08:00 -0700
Subject: [PATCH i2c-next v7 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
In-Reply-To: <20181005214507.26315-6-jae.hyun.yoo@linux.intel.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-6-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g45JkK4BnGR7yOA3eCazTZ86FyUaNdi81Ew6VBbKxS3EZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In multi-master environment, this driver's master cannot know
> exactly when peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver.
>
> To prevent any state corruption in the case, this patch adds
> checking code if any slave operation is ongoing and it waits up to
> the bus timeout duration before starting a master_xfer operation.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
