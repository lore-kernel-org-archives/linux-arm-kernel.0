From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 13 Feb 2015 09:09:20 +0100
Subject: [PATCH 10/11] ARM: sti: always enable RESET_CONTROLLER
In-Reply-To: <1423770163-583064-11-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-11-git-send-email-arnd@arndb.de>
Message-ID: <54DDB130.9020600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
On 02/12/2015 08:42 PM, Arnd Bergmann wrote:
> A lot of the sti device drivers require reset controller support,
> but do not all have individual 'depends on RESET_CONTROLLER'
> statements. Using 'select' here once avoids a lot of build errors
> resulting from this.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/mach-sti/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>

I agree with you, the board is useless without all the drivers depending 
on the resets.

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Br,
Maxime
