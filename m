From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Jan 2013 15:02:08 +0800
Subject: [PATCH] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
In-Reply-To: <CAOh2x=kCKbxX6ThzEty0F-MxxhsRMhh8++Nc7BqBaXNfaozoJw@mail.gmail.com>
References: <1359208550-16402-1-git-send-email-shawn.guo@linaro.org>
 <CAOh2x=kCKbxX6ThzEty0F-MxxhsRMhh8++Nc7BqBaXNfaozoJw@mail.gmail.com>
Message-ID: <20130128070206.GB31689@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 09:42:29AM +0530, Viresh Kumar wrote:
> >         struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
> >         platform_device_register_full(&devinfo);
> 
> Something similar was being discussed with Andrew (cc'd) on his patch
> for kikwood cpufreq driver.
> 
> We shouldn't encourage addition of above as we are moving towards DT.

Moving towards DT does not really mean that we should never register
platform_device from platform code.  DT is designed to present physical
devices, while what I'm adding here is somewhat a virtual one.  I'm
just using the platform_device/platform_driver mechanism to instantiate
the driver on particular platform.

> So, i would except an compatible array too in your patch and then driver
> can be probed based on compatible string being present in cpu node.

I believe device tree maintainer already stated that we should not
have node/compatible for cpuidle/cpufreq such stuff in DT merely for
asking DT core to create platform_device for them.

Shawn
