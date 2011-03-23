From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Mar 2011 16:20:22 +0000
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
References: <20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
	<AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
	<20110322165907.GG22583@opensource.wolfsonmicro.com>
	<AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
Message-ID: <20110323162021.GA26594@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 01:04:31AM +0900, Magnus Damm wrote:

> Sounds nice. Hopefully that will allow us to use module_init() in
> drivers instead of other initcall levels depending on bus type.

None of this is anything to do with the bus type - it's to do with the
function of the devices within the system.  Things that are required for
early init of the kernel get bumped up the list.
