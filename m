From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 30 Apr 2015 17:37:58 +0530
Subject: [PATCH V4 0/3] OPP: Introduce OPP (V2) bindings
Message-ID: <cover.1430394884.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys (Specially Stephen),

These are dangling since a long time now and I am really getting discouraged to
take these further. Not many people have reviewed them, apart from few nice
folks.

One last try ..

I have tried to take care of most of the concerns you had Stephen, please let me
know if they workout for you or you don't want these bindings to take care of
qcom stuff at all. Then we can keep them simple and carry on. Ofcourse we would
like to handle every platform here :)

V3->V4:
- Dropped code changes as we are still concerned about bindings.
- separated out into three patches, some of which might be NAK'd. :)
- The first patch presents basic OPP stuff that was reviewed earlier. It also
  has support for multiple regulators, with values for both current and voltage.
- Second patch is based on a special concern that Stephen had about multiple OPP
  tables, one of which the parsing code will select at runtime.
- Third one separates out 'opp-next' or Intermediate freq support as Mike T. had
  few concerns over it. He wanted the clock driver to take care of this and so
  do not want it to be passed by DT and used by cpufreq. Also, there were
  concerns like the platform may not want to choose intermediate frequency as a
  target frequency for longer runs, which wasn't prevented in earlier bindings.
  And so it is kept separate to be NAK'd quietly, without much disturbances.

  ---------------x-------------------x------------------------

Current OPP (Operating performance point) DT bindings are proven to be
insufficient at multiple instances.

The shortcomings we are trying to solve here:

- Getting clock sharing information between CPUs. Single shared clock vs
  independent clock per core vs shared clock per cluster.

- Support for specifying current levels along with voltages.

- Support for multiple regulators.

- Support for turbo modes.

- Other per OPP settings: transition latencies, disabled status, etc.?

- Expandability of OPPs in future.

This patchset shows a path forward to get all these fixed. Please give some
comments this time and lets get this done.

--
viresh

Viresh Kumar (3):
  OPP: Redefine bindings to overcome shortcomings
  OPP: Allow multiple OPP tables to be passed via DT
  OPP: Add 'opp-next' in operating-points-v2 bindings

 Documentation/devicetree/bindings/power/opp.txt | 501 +++++++++++++++++++++++-
 1 file changed, 497 insertions(+), 4 deletions(-)

-- 
2.3.0.rc0.44.ga94655d
