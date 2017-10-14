From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 14 Oct 2017 10:41:20 -0300
Subject: [PATCH 1/3] drm: bridge: synopsys/dw-hdmi: Enable cec clock
In-Reply-To: <CAJ-oXjQG9pbrXpTWyPWnJZ30DBkcQ1vjMG26rQunZq4V_-k8-w@mail.gmail.com>
References: <20171013225337.5196-1-phh@phh.me>
 <20171013225337.5196-2-phh@phh.me>
 <CAOMZO5CtP=A0jF1FimScjSUvv-t6a2ua=ungr0LUHmQvUTKr3Q@mail.gmail.com>
 <CAJ-oXjQG9pbrXpTWyPWnJZ30DBkcQ1vjMG26rQunZq4V_-k8-w@mail.gmail.com>
Message-ID: <CAOMZO5AxNRj5o0cw1-bjtZbHeQZwZJ0dYV+zPBd8TKxpSZxizQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre,

On Sat, Oct 14, 2017 at 10:21 AM, Pierre-Hugues Husson <phh@phh.me> wrote:

> As far as I understand, dw_hdmi_cec_enable only gates
> the CEC clock inside the Synopsis IP,
> but the SOC still has to provide a specific CEC clock to it.
> To enable such an external CEC clock, the binding documentation [1]
> mentions a "cec" optional clock, and I'm not seeing any code in dw-hdmi
> to enable it.

Ok, understood.

In the case of i.MX6 we control the CEC clock via
HDMI_MC_CLKDIS_CECCLK_DISABLE bit inside the Synopsis IP.

Looks like Rockchip needs the external CEC clock then.

Regards,

Fabio Estevam
