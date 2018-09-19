From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Sep 2018 14:40:58 -0700
Subject: [PATCH 07/11] cpufreq: mvebu: Remove OPPs using
 dev_pm_opp_remove()
In-Reply-To: <87o9ctjyz3.fsf@bootlin.com>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
 <87o9ctjyz3.fsf@bootlin.com>
Message-ID: <20180919214058.bp325gyowqyveil2@vireshk-mac-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-09-18, 17:20, Gregory CLEMENT wrote:
> Hi Viresh,
>  
>  On mer., sept. 12 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> > and will not remove dynamic OPPs automatically. They must be removed
> > with a call to dev_pm_opp_remove().
> 
> So now that mean when adding more than 2 OPPs, we should have the list
> of them available in the driver to be able to remove them, right?

Right. Maybe we will add a separate API to remove all dynamic ones in
one go but I couldn't find any platform which needs to do it right
now.

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks.

-- 
viresh
