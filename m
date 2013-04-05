From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 4 Apr 2013 22:03:54 -0400 (EDT)
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <alpine.LFD.2.03.1304022258430.1171@syhkavp.arg>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <20130328134808.GD16765@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1304022258430.1171@syhkavp.arg>
Message-ID: <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I want to deplore a situation that highlights a bottleneck with our 
current upstreaming process on ARM affecting the MCPM patch series I'm 
maintaining.

This patch series has been extensively reviewed.

1st review cycle (10 Jan 2013):
http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=208625

2nd review cycle (24 Jan 2013):
http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=212196

3rd review cycle (29 Jan 2013):
http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=213562

4th review cycle (5 Feb 2013):
http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=215477

The following people were involved in the discussion:

  Achin Gupta
  Catalin Marinas
  Dave Martin
  Jon Medhurst
  Joseph Lo
  Lorenzo Pieralisi
  Saeed Bishara
  Santosh Shilimkar
  Stephen Boyd
  Rob Herring
  Pawel Moll
  Will Deacon

Resulting review comments were all addressed.  

So, a pull request for the v3.8 merge window was posted (6 Feb 2013):
http://article.gmane.org/gmane.linux.ports.arm.kernel/216061

This, however, didn't get merged in time due to some miscommunication
about non technical reasons.  I therefore won't expose those reasons 
here.  Suffice to say that a merge window was missed.

Therefore, this was followed by another pull request for the v3.9 merge window (25 Mar 2013):
http://article.gmane.org/gmane.linux.ports.arm.kernel/225873

Followed by a merge plan inquiry from Lorenzo (28 Mar 2013):
http://article.gmane.org/gmane.linux.ports.arm.kernel/227035

To end up with my ping (3 Apr 2013):
http://article.gmane.org/gmane.linux.ports.arm.kernel/228209

Russell mentioned having issues with the mailing list traffic and pull
request being buried.  He therefore suggested a special email alias
to filter pull requests (22 Mar 2013):
http://article.gmane.org/gmane.linux.ports.arm.kernel/225377

The last pull request used that alias, and the latest ping did use both 
the pull alias as well as his regular email address.

We're approaching v3.9-rc6, and there is still no sign of this patch set 
being headed for mainline yet.  The system is _not_ working if this 
series is to miss yet another merge window.

On March 28th, Russell mentioned he'd be sporadically away for the 
following two weeks, and suggested that the GIC patches go through the 
ARM SoC tree:
http://article.gmane.org/gmane.linux.ports.arm.kernel/227040

Given the lack of backup to pick up the load when Russell is unavailable 
(seeing the next merge window approaching and still no response from my 
latest pull request and its subsequent recalls), I'm questionning the 
current process scalability. Therefore, at this point, I'm suggesting 
that the MCPM series be merged in the ARM SoC tree as well, as a backup 
solution.

After all, this series is a prerequisite for more patches about platform 
specific patches meant for the ARM SoC tree but which currently are 
still waiting.  Having the prerequisite in the ARM SOC tree will allow 
for those patches to be exposed earlier.


Nicolas
