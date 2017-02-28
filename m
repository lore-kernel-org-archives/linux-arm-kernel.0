From: dianders@chromium.org (Doug Anderson)
Date: Tue, 28 Feb 2017 14:54:33 -0800
Subject: [PATCH v2 4/6] arm64: dts: rockchip: add Gru/Kevin DTS
In-Reply-To: <6978416.eyJmBK6ozI@phil>
References: <20170210010521.78872-1-briannorris@chromium.org>
 <20170210010521.78872-5-briannorris@chromium.org> <6978416.eyJmBK6ozI@phil>
Message-ID: <CAD=FV=VS6YBjUQsix=nHteKG6jt=+LGWpDSqrP4VRu5LxOVc3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 28, 2017 at 2:00 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> +     pp3300_wifi_bt: pp3300-wifi-bt {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "pp3300_wifi_bt";
>> +             /* NOTE: wlan_module_pd_l pinctrl in pp1800_pcie */
>> +
>> +             enable-active-high;
>> +
>> +             /* NOTE: this GPIO also used in pp1800_pcie */
>
> does the gpio subsystem like this double usage?

Yes, see commit f19b00da8ed3 ("regulator: core: support shared enable
GPIO concept").  ...but there's no great place to put the pinctrl node
though, unfortunately.  It's either randomly pick one of the two or
add it as a system-level hog.

-Doug
