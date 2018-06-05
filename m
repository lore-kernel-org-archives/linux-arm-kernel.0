From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 6 Jun 2018 00:02:20 +0800
Subject: [PATCH V2 2/2] arm: dts: sunxi: Add missing cooling device
 properties for CPUs
In-Reply-To: <20180605071139.osu2pgpg3ychdxln@flea>
References: <20180601151701.sshwfdbflic6mybv@flea>
 <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
 <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
 <20180605071139.osu2pgpg3ychdxln@flea>
Message-ID: <CAGb2v65EX2RwKjxPw+EK4i6rkfgOJoCU2amuFkF-tHQT40isxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2018 at 3:11 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Jun 05, 2018 at 10:17:49AM +0530, Viresh Kumar wrote:
>> The cooling device properties, like "#cooling-cells" and
>> "dynamic-power-coefficient", should either be present for all the CPUs
>> of a cluster or none. If these are present only for a subset of CPUs of
>> a cluster then things will start falling apart as soon as the CPUs are
>> brought online in a different order. For example, this will happen
>> because the operating system looks for such properties in the CPU node
>> it is trying to bring up, so that it can register a cooling device.
>>
>> Add such missing properties.
>>
>> Fix other missing properties (clocks, OPP, clock latency) as well to
>> make it all work.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Applied both, thanks!

Please fix the "ARM" prefix when applying. :)

ChenYu
