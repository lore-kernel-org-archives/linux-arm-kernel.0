From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 18:20:23 +0200
Subject: [RFC 7/8] ARM:stih41x: Add B2000 board support
In-Reply-To: <1368022329-2424-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022329-2424-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201305081820.23968.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> diff --git a/arch/arm/mach-stih41x/board-dt.c b/arch/arm/mach-stih41x/board-dt.c
> index 8005f71..1f23aca 100644
> --- a/arch/arm/mach-stih41x/board-dt.c
> +++ b/arch/arm/mach-stih41x/board-dt.c
> @@ -63,6 +63,8 @@ void __init stih41x_dt_init(void)
>  }
>  
>  static const char *stih41x_dt_match[] __initdata = {
> +       "st,stih415-b2000",
> +       "st,stih416-b2000",
>         NULL
>  };

I probably wouldn't bother listing all the boards here. Just make sure
the .dts file lists both the name of the board and of the soc in
its compatible property, and list all the SoCs here that you can boot on.

	Arnd
