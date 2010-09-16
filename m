From: thara@ti.com (Gopinath, Thara)
Date: Thu, 16 Sep 2010 16:03:13 +0530
Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014F09CDD5@dlee02.ent.ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424E7@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C014F09CDD5@dlee02.ent.ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03294424EF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Thursday, September 16, 2010 4:02 PM
>>To: Gopinath, Thara; Kevin Hilman; linux-omap at vger.kernel.org
>>Cc: linux-arm-kernel at lists.infradead.org
>>Subject: RE: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
>>
>>> -----Original Message-----
>>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>>> owner at vger.kernel.org] On Behalf Of Gopinath, Thara
>>
>>[...]
>>> >>diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-
>>> omap/include/plat/opp.h
>>> >>new file mode 100644
>>> >>index 0000000..997b56e
>>> >>--- /dev/null
>>> >>+++ b/arch/arm/plat-omap/include/plat/opp.h
>>[..]
>>> >>+
>>> >>+#ifdef CONFIG_PM
>>> >>+
>>[..]
>>> >>+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long
>>> *freq);
>>> >>+
>>> >>+int opp_add(const struct omap_opp_def *opp_def);
>>> >>+
>>> >>+int opp_enable(struct omap_opp *opp);
>>> >>+
>>> >>+int opp_disable(struct omap_opp *opp);
>>> >>+
>>> >>+void opp_init_cpufreq_table(struct device *dev,
>>> >>+			    struct cpufreq_frequency_table **table);
>>> >>+#else
>>>
>>> Hello Kevin,
>>>
>>> IN case of CONFIG_PM not being defined the else part will cause a
>>> compilation break as
>>> the signature of these APIs defined in the else part do not match with the
>>> signature in
>>> the if part.
>>>
>>Thanks for the catch. Will send a patch for this.

I learnt this the hard way by actually hitting the issue :-)!!

Regards
Thara
