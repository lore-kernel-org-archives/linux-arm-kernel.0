From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 19 Aug 2016 11:19:13 -0500
Subject: [PATCH v2 1/4] nvmem: rockchip-efuse: Change initcall to subsys
In-Reply-To: <2844104.lMUOkH8YJy@phil> (Heiko Stuebner's message of "Fri, 19
 Aug 2016 00:29:55 +0200")
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <1471510341-63926-2-git-send-email-finley.xiao@rock-chips.com>
 <m2mvkaq6c5.fsf@baylibre.com> <2844104.lMUOkH8YJy@phil>
Message-ID: <m2a8g8n33y.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko Stuebner <heiko@sntech.de> writes:

> Am Donnerstag, 18. August 2016, 13:28:58 CEST schrieb Kevin Hilman:
>> Finlye Xiao <finley.xiao@rock-chips.com> writes:
>> > From: Finley Xiao <finley.xiao@rock-chips.com>
>> > 
>> > We will register a cpufreq notifier for adjusting opp's voltage, and it
>> > need to fetch cpu's leakage from efuse in the notifier_call. so the efuse
>> > driver should probe before cpufreq driver.
>> > 
>> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> 
>> Why can't this be handled with deferred probling?  initcall ordering is
>> a can of worms.
>
> I think the issue is less between efuse and avs driver, but more between avs 
> driver and cpufreq. The avs driver aims to modify the opp table and thus wants 
> to do that / register the notifier before cpufreq starts.
>
> And as there is no direct connection between cpufreq and the avs driver, 
> making cpufreq defer probing is probably not really easy.

Thanks for the explanation.

Sounds like something that belongs in the changelog.

Kevin
