From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Oct 2013 09:59:26 +0530
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131022155758.GA26694@lunn.ch>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
 <1382186261-14482-2-git-send-email-andrew@lunn.ch>
 <CAKohpok2scsSU7eFOP5LYmQar8xfOqG4-b3z4sVS6JOgnxVcpw@mail.gmail.com>
 <20131022155758.GA26694@lunn.ch>
Message-ID: <CAKohpo=7nw4ECXg_5e2wJQ8-+ie4Q0cuC+LpLOAePJ6AmCT2EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 October 2013 21:27, Andrew Lunn <andrew@lunn.ch> wrote:
> The hardware raises an interrupt when the change is complete. This
> interrupt is what brings the CPU out of the WFI. I don't know the
> interrupt code too well, but i think it is necessary for the driver to
> acknowledged it. The interrupt core code counts interrupts which
> nobody acknowledges, and after 1000 are received, it disables the
> interrupt. That would probably result in the machine locking solid,
> never coming out of the WFI. So i'm playing it safe and handling the
> interrupt.

Theory looks correct AFAIK.. But it would be better to give it a try
on real hardware, hopefully you have that :)

Also, in case this is required, it would be better to document it a bit
over the routine..

> In theory yes. In practice no. It is a fixed rate clock. prepare and
> enable are actually NOPs for this type of clock. However the API
> documentation explicitly states you need to call prepare and enable
> before you can call clk_get_rate(). But i can add error checking if
> you want.

Leave it then..
