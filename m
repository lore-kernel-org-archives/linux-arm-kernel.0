From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 13 Jun 2014 13:59:28 +0100
Subject: Latest mainline (3.16 merge window) does not boot in B2020/STiH416
Message-ID: <539AF5B0.6060509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks

Using the lastest Linus T. mainline it is no longer possible to boot a
B2020/STiH416.

The kernel boots OK and issues UART messages, but the system gets stuck
trying to mount the NFS root filesystem.

Configuration is multi_v7_defconfig+CGROUPS+AUTOFS4_FS+IPV6 (although
the deviations from multi_v7_defconfig should make little difference).

An automated bisect identified the first broken version as:
--- cut here ---
commit 948d8ffb4775705c729501f9a433d05163e2f253
Author: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Date:   Fri Apr 11 17:07:00 2014 +0200

    ARM: STi: DT: add keyscan for stih416

    Add keyscan support for stih416.
    It is disabled by default given that it is not enabled on all boards.
    Also there are PIOs conflict with already claimed lines.

    Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
    Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
    Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
--- cut here ---

Unfortunately 'git revert 948d8ffb4775705c729501f9a433d05163e2f253' is
insufficient to get things working when merged back to head.

Feel free to ask for any help in resolving the problem.


Daniel.
