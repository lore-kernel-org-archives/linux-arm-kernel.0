From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:12:23 -0400
Subject: [PATCH v3 07/12] sched: test the cpu's capacity in wake affine
In-Reply-To: <1404144343-18720-8-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-8-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53BCB317.4050400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/30/2014 12:05 PM, Vincent Guittot wrote:
> Currently the task always wakes affine on this_cpu if the latter is
> idle. Before waking up the task on this_cpu, we check that this_cpu
> capacity is not significantly reduced because of RT tasks or irq
> activity.
> 
> Use case where the number of irq and/or the time spent under irq is
> important will take benefit of this because the task that is woken
> up by irq or softirq will not use the same CPU than irq (and
> softirq) but a idle one which share its cache.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@redhat.com>


- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLMXAAoJEM553pKExN6DGwcIAIDInqWSTMPG1SpNPIgrDB4g
YILWx6pFhv1ZSVEiJ05jxNpDKHeAKaEFR9NrSA/Psd+0p1zZ0pazioXyVhhr92PO
2C/xnIDsxNp7Qf+Yz1OvAHdoZiBM/uOI60JU+xL3bF/npjrw6DWe4WitikAookRR
Yjwhtyj4KiVgXBYDWuES5HS5s61W+ol1F3as6KKMurfwU6JYXqJYMRZGQoymi144
5oV9enFgN3u6kXhXUMgC3vfzVW2xMr7SNDTvEDO0vqrvlIRsv07u63G0YppoMFbI
Mht3ARLZKOwR6paiju1IkBdy/4nZeAuO461hDKwb/bB5q3JdeUtXw89xbelJD1Y=
=H6O5
-----END PGP SIGNATURE-----
