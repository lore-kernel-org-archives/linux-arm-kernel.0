From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 14 Jul 2014 10:54:18 +0530
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB661A47A2A7BF3@EAPEX1MAIL1.st.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
 <53BE926A.2070005@ti.com>
 <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
 <53BFA120.2070005@ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB661A47A2A7BF3@EAPEX1MAIL1.st.com>
Message-ID: <CAKohpo=UNwzppiTHzg0qxFBdkiR8fkwTu27OKKPTUFo5GVDKcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2014 10:52, Mohit KUMAR DCG <Mohit.KUMAR@st.com> wrote:
> - I think we should read regmap_*() and msleep() in continuation and so the comment above it
> is valid for both the operations.

Probably not, its not obvious why a msleep() is required after regmap_*().

> Otherwise we can add comment line for msleep() like:
> /* Wait for SATA power domain on */
> /* Wait for SATA reset de-assert completion */
>
> Similarily in *_exit routine:
> /* Wait for SATA power domain off */
> /* Wait for SATA reset assert completion */

These makes sense. Will add them.
