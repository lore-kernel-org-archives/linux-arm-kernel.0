From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 13:20:32 +0800
Subject: [PATCH v5 02/23] of: device: Export of_device_{get_modalias,
 uvent_modalias} to modules
In-Reply-To: <20161018015636.11701-3-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-3-stephen.boyd@linaro.org>
Message-ID: <CAGb2v65n3ciP6dud8EqPU+pn0JnO+-Oqxgm+Z3vs+j-A7AbL1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 9:56 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> The ULPI bus can be built as a module, and it will soon be
> calling these functions when it supports probing devices from DT.
> Export them so they can be used by the ULPI module.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

I'm interested in this as well. The sunxi-rsb bus is non-enumerable
and DT only, and existing slave device drivers can be built as modules.
We'd need this to support modalias loading of drivers.

ChenYu
