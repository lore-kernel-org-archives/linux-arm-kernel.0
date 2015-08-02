From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 3 Aug 2015 09:35:51 +1000
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timo,

On Mon, Aug 3, 2015 at 5:23 AM, Timo Sigurdsson
<public_timo.s@silentcreek.de> wrote:
> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20 boards
> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
> voltage for the lowest operating point to 1.0V so all boards can actually use
> it.

Surely it wouldn't be added here if some could supply 0.9v.

Is the code that uses this smart enough to sensibly switch between two
operating points with the same frequency and different voltages? If
so, maybe just add a 144MHz @ 1.0v operating point?

(Alternatively, would it make sense to modify the code that uses this
to use frequencies with voltages specified that are lower than can be
supplied with the lowest voltage it can?)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
