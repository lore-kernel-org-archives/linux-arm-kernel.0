From: david.wu@rock-chips.com (David.Wu)
Date: Wed, 2 Aug 2017 19:31:57 +0800
Subject: [PATCH v2 3/7] pwm: rockchip: Remove the dumplicate
 rockchip_pwm_ops ops
In-Reply-To: <20170802105902.2d137072@bbrezillon>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
 <1499486629-9659-4-git-send-email-david.wu@rock-chips.com>
 <20170802105902.2d137072@bbrezillon>
Message-ID: <af056420-5c33-e6c8-62cb-bcd3456000a7@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

? 2017/8/2 16:59, Boris Brezillon ??:
> Actually, when I suggested to just implement ->apply_state() and be
> done with all other fields I was thinking that you could get rid of
> this rockchip_pwm_data struct entirely and just have 3 different
> pwm_ops. You seem to take the other direction here: you're removing
> rockchip_pwm_ops_v1 and renaming rockchip_pwm_ops_v2 into
> rockchip_pwm_ops.

Yes, i really didn't understand exactly what you mean.
Your mean is that remove the set_enable, get_state and other hooks,
then use the pwm_ops instead of them, which has 3 different version, and 
implement the pwm_ops's functions like apply(), enable(), get_state() 
and others...?
