From: olof@lixom.net (Olof Johansson)
Date: Sun, 9 Jun 2013 17:13:31 -0700
Subject: [PATCH 0/2] ARM: multiple-platforms: fix the kernel panic on
 non-SiRF platforms
In-Reply-To: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
References: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130610001331.GA21645@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 10:34:13AM +0800, Barry Song wrote:
> These two patches fix the kernel panic for multiple-platform kernel to run on non-SiRF
> platforms.
> 
> It depends on patches I sent in the pull-request mail
> [GIT PULL] SiRF fixes for the v3.10 series
> at:
> http://www.spinics.net/lists/arm-kernel/msg247521.html
> 
> And thanks for the original patchset from Srinivas Kandagatla <srinivas.kandagatla@st.com>

Hi,

A better and more narrow fix for 3.10 would be to gracefully abort the
initcalls if the device nodes are not found, which is what I had as original
feedback on these patches in the first place. Print an error but continue
booting.


-Olof
