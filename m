From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 22 Mar 2017 11:31:54 +0800
Subject: [PATCH v3 02/11] ARM: sun8i: a33: add all operating points
In-Reply-To: <20170321153611.16228-3-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-3-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v64MHK7A-FhZR5KBbDji4VvnhJukqDz0Ude-LjS2YgVVfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds almost all operating points allowed for the A33 as defined by
> fex files available at:
> https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33
>
> There are more possible frequencies in this patch than there are in the
> fex files because the fex files only give an interval of possible
> frequencies for a given voltage. All supported frequencies are defined
> in the original driver code in Allwinner vendor tree.
>
> There are two missing frequencies though: 1104MHz and 1200MHz which
> require the CPU to have 1.32V supplied, which is higher than the default
> voltage.
>
> Without all A33 boards defining the CPU regulator, we cannot have these
> two frequencies as it would cause the CPU to try to run a higher
> frequency without "overvolting" which is very likely to crash the CPU.
>
> Therefore, these two frequencies must be enabled on a per-board basis.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
