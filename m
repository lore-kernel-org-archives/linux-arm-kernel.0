From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 16 Jun 2015 08:50:19 -0700
Subject: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for cpu
 domain
In-Reply-To: <20150615191434.GA14311@linaro.org> (Lina Iyer's message of "Mon,
 15 Jun 2015 13:14:34 -0600")
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <7hmw07meh6.fsf@deeprootsystems.com>
 <20150611145649.GC1103@linaro.org>
 <7hioao6cd2.fsf@deeprootsystems.com>
 <20150615191434.GA14311@linaro.org>
Message-ID: <7h381rzm84.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Mon, Jun 15 2015 at 12:43 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> On Wed, Jun 10 2015 at 15:38 -0600, Kevin Hilman wrote:
>>>>Lina Iyer <lina.iyer@linaro.org> writes:
>
>
>>I'm pretty sure the generic code will already add devices to genpds if
>>the genpd is using the of_genpd_* stuff.  That is why I'm wondering why
>>the extra stuff for CPUs is needed.
>>
> I dont see that automatically happening. When I attach a device, it
> finds the corresponding genpd provider and attaches the device.  But I
> dont see in any code that creates genpd and find the related device
> nodes and adds them to the genpd.

[summary from our IRC discussion]

You still need to create the genpd, but it's dev_pm_domain_attach()
called by the platform device probe path that will automaticaly try to
attach a device with a power-domains property to the correct PM domain.

Note that this assumes that the genpds are created before the devices
are probed.

Kevin
