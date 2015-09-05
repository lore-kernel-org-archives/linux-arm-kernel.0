From: dianders@chromium.org (Doug Anderson)
Date: Sat, 5 Sep 2015 12:44:51 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <20150905140136.GM21084@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083107.GK21084@n2100.arm.linux.org.uk>
 <CAD=FV=XzPRHE6n-svm=0_9jXUORY5NPzfmgS0Ncp7PXXbqivOw@mail.gmail.com>
 <20150905140136.GM21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=WsKgQRrKNmN+sFwQBCC2XiJLOg-yzg5w6w8n6qk8MjRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 5, 2015 at 7:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> If you know the answer, just tell me.  If you're talking about 74.25
>> vs. 32 kHz it is further evidence of what I'm saying.  Note that
>> picking only one of the two listed CTS values again puts you in a
>> worse position for regenerating the proper audio clock then just using
>> the default N=4096.
>
> No it doesn't.
>
> 74.25MHz/1.001 * 4096 / (128 * 32000) = 74175 (rounded down)
>
> Now do the calcuation.
>
> (74.25MHz/1.001) / 74175 * 4096 = 4096045.511 => 32000.35556Hz
>         => error of 0.001111%
>
> Now for the calcuation using the proscribed figures.
>
> (74.25MHz/1.001) / 210937 * 11648 = 4096009.709 => 32000.07585Hz
>         => error of 0.000237%
>

Why would you round down???  Round to the closest.

(74250000 / 1.001 * 4096)  / (128 * 32000.)
=> 74175.82417582418
=> 74176

(74250000 / 1.001) / 74176 * 4096 / 128
=> 31999.924148327947

That's actually the same error as yours: 0.000237%

You're right.  Yours isn't worse, but it's also not any better.
