From: sf84@laposte.net (Sebastian Frias)
Date: Wed, 24 Aug 2016 16:29:02 +0200
Subject: ARM,SoC: About the use DT-defined properties by 3rd-party drivers
Message-ID: <57BDAF2E.10502@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Given a SoC and its SDK, 3rd party users of said SoC (customers of the SoC's
manufacturer) may need/want to write kernel modules.
Since the DT describes the HW, it would make sense to expose some HW properties
through the DT, and have 3rd party users rely on them to write their drivers in
a generic way.
However, it seems that one is not allowed to upstream DT bindings and
properties without a driver, is that right?

If true, that hampers DT usage by out-of-tree drivers (or in this case,
drivers that are not written yet) and limits the usage of DT properties as an
API.

We can understand that DT maintainers want to know what goes upstream,
make sure that the bindings are documented, that there are no conflicts with
other bindings or generic strings, etc.
However, it is hard to see why there is not a "relaxed" upstreaming path
for SoC-specific properties (i.e.: that do not affect DT API nor other
SoCs).

As an example, we would like to add some properties to /soc/ like:

   soc {
       compatible = "simple-bus";
       ...
       sigma-register-layout-version = <2>;
       sigma-has-XYZ-capability;

and so on.

If this is really not possible, it forces the SoC manufacturer to expose
those properties in a different way, thus wasting a (seemingly) perfectly
fine way of doing so: the DT and its documentation.

Thoughts?

By the way, what about properties generated on-the-fly by the bootloader?

Thanks in advance.
Best regards,

Sebastian
