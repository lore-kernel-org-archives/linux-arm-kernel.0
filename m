From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 18 Nov 2015 10:09:31 -0600
Subject: [PATCH] arm64: Implement CONFIG_CMDLINE_EXTEND
In-Reply-To: <1447838885-9888-1-git-send-email-p.fedin@samsung.com>
References: <1447838885-9888-1-git-send-email-p.fedin@samsung.com>
Message-ID: <CAL_JsqLiXQsjf_Op_MtHDM_4t-Nz1fK8KRPoFi1e+ftdjLZJ2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 3:28 AM, Pavel Fedin <p.fedin@samsung.com> wrote:
> Add an option to extend built-in command line with one obtained from
> the device tree.
>
> This option is very useful for, for example, switching between some
> stable and development version, when one of them requires additional
> arguments (e. g. to turn on some extra debug). It can be annoying to
> reprogram command line in the bootloaded every time.
>
> Actually, this patch introduces the necessary support to all
> architectures using the device tree, however only arm64 Kconfig is
> modified, because this is the only platform i can test.

There is work to make the cmdline options and handling generic[1].
There are lots of sharp corners here and I'd like to sort out the
generic support before adding more combinations.

Rob

[1] http://www.spinics.net/lists/arm-kernel/msg449844.html
