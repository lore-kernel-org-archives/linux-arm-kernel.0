From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:10:36 -0400
Subject: [PATCH v3 03/12] sched: fix avg_load computation
In-Reply-To: <1404144343-18720-4-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53BCB2AC.2090704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/30/2014 12:05 PM, Vincent Guittot wrote:
> The computation of avg_load and avg_load_per_task should only takes
> into account the number of cfs tasks. The non cfs task are already
> taken into account by decreasing the cpu's capacity (cpu_power) and
> they will be tracked in the CPU's utilization (group_utilization)
> of the next patches
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@redhat.com>

- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLKrAAoJEM553pKExN6Dcz4H/2lJUVmEEzBOxc23cbYSXJcR
E1shwcwfbGe/0GwHwWOB4+9UyDuxp6pO6PaQ581nZZZ3sWSifjrViJqtoBheoERY
yIH3zbnpPVBD3JNOVA/5XjHSdnYye/Qf23TVsaC/Jd2O8MH3oilJFJTbOoeU+ns7
DREwq0T4T7RnLo9oVc6eLyWf9Ouc3FufAH41u48y702Ppbw1qnOU/ZSRhTLWpgoR
PjybIcEaNBugMHxv4CCjcU74VkYGoMupN93QZeuG71MwOjbkUQIIRwp4De9MW0Rw
59eO97StrE6o3oLcNaoqHPM3OzyvejF03soW6jROQJsTq3Ck7nD9jjGwav+TwO4=
=TC6D
-----END PGP SIGNATURE-----
