From: phh@phh.me (Pierre-Hugues Husson)
Date: Sat, 14 Oct 2017 15:21:17 +0200
Subject: [PATCH 1/3] drm: bridge: synopsys/dw-hdmi: Enable cec clock
In-Reply-To: <CAOMZO5CtP=A0jF1FimScjSUvv-t6a2ua=ungr0LUHmQvUTKr3Q@mail.gmail.com>
References: <20171013225337.5196-1-phh@phh.me>
 <20171013225337.5196-2-phh@phh.me>
 <CAOMZO5CtP=A0jF1FimScjSUvv-t6a2ua=ungr0LUHmQvUTKr3Q@mail.gmail.com>
Message-ID: <CAJ-oXjQG9pbrXpTWyPWnJZ30DBkcQ1vjMG26rQunZq4V_-k8-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

2017-10-14 2:18 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
> Hi Pierre-Hugues,
>
> On Fri, Oct 13, 2017 at 7:53 PM, Pierre-Hugues Husson <phh@phh.me> wrote:
>> The documentation already mentions "cec" optional clock, but
>> currently the driver doesn't enable it.
>
> The cec clock is enabled at dw_hdmi_cec_enable().
As far as I understand, dw_hdmi_cec_enable only gates
the CEC clock inside the Synopsis IP,
but the SOC still has to provide a specific CEC clock to it.
To enable such an external CEC clock, the binding documentation [1]
mentions a "cec" optional clock, and I'm not seeing any code in dw-hdmi
to enable it.

Regards,

[1] On next-20170929
Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt line 28
