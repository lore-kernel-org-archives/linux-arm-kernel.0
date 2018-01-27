From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 26 Jan 2018 22:28:30 -0200
Subject: [PATCH] ARM: dts: imx25-pinfunc: Always set SION for SD CMD
In-Reply-To: <20180127000752.2879-1-benoit.thebaudeau.dev@gmail.com>
References: <20180127000752.2879-1-benoit.thebaudeau.dev@gmail.com>
Message-ID: <CAOMZO5Dfrj9H4t6T2NJH3BQ49yAx3k3a=5HRFcR+Ce5dneBfKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 10:07 PM, Beno?t Th?baudeau
<benoit.thebaudeau.dev@gmail.com> wrote:
> The eSDHC does not work properly if the SION bit is not set for the
> bidirectional CMD signal, whatever the eSDHC instance and the selected
> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> this for MX25_PAD_*__SD*_CMD in imx25-pinfunc.h in order to enforce this
> behavior for all boards.
>
> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> MX25_PAD_FEC_MDC__SDHC2_CMD so that all the possible cases are covered
> from now on.
>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau.dev@gmail.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
