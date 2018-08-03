From: evgreen@chromium.org (Evan Green)
Date: Fri, 3 Aug 2018 15:59:56 -0700
Subject: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
In-Reply-To: <20180731161340.13000-9-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
Message-ID: <CAE=gft7+3n-Phh-FdamSFRZVq49Z234_HfU3Ze0MGJiYXGEmcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation function
> to help us get the board specific interconnect data from device-tree.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h |  7 ++++
>  2 files changed, 69 insertions(+)
>

FWIW I don't have any strong opinions on whether of_icc_get returns an
error or NULL, other than to suggest following suit with what other
frameworks have chosen to do. Though perhaps most other frameworks are
not quite as optional for a particular driver.

Reviewed-by: Evan Green <evgreen@chromium.org>
