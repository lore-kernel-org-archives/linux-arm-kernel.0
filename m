From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 4 Jun 2018 12:44:35 +0530
Subject: [PATCH 6/6] arm64: dts: socionext: Add missing cooling device
 properties for CPUs
In-Reply-To: <CAK7LNASv90x3QKPYEy-3Msow0wi99hV8aRiU32aAjS7jMJKydA@mail.gmail.com>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <744f4c0a9a6f0d3acfc36e49ef62f17f53831b3b.1527225682.git.viresh.kumar@linaro.org>
 <CAK7LNASv90x3QKPYEy-3Msow0wi99hV8aRiU32aAjS7jMJKydA@mail.gmail.com>
Message-ID: <20180604071435.moiw5t44yn3wvrvo@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-06-18, 12:25, Masahiro Yamada wrote:
> 2018-05-25 14:40 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> > The cooling device properties, like "#cooling-cells" and
> > "dynamic-power-coefficient", should either be present for all the CPUs
> > of a cluster or none. If these are present only for a subset of CPUs of
> > a cluster then things will start falling apart as soon as the CPUs are
> > brought online in a different order. For example, this will happen
> > because the operating system looks for such properties in the CPU node
> > it is trying to bring up, so that it can register a cooling device.
> >
> > Add such missing properties.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 
> Applied to linux-uniphier.
> 
> I had already sent a PR for v4.18-rc1 before I received this patch.
> Please wait for v4.19-rc1.

Sure, no hurry. Though I thought this kind of fixes can go in 4.18-rc2 as well,
isn't it ?

-- 
viresh
