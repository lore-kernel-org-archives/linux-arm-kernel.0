From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 20 Jan 2014 10:39:53 +1100
Subject: linux-next: build warning after merge of the arm-soc tree
Message-ID: <20140120103953.329bd64dd540d547956ff46c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/pinctrl/pinconf.c: In function 'pinconf_pins_show':
drivers/pinctrl/pinconf.c:299:28: warning: unused variable 'ops' [-Wunused-variable]
  const struct pinconf_ops *ops = pctldev->desc->confops;
                            ^
drivers/pinctrl/pinconf.c: In function 'pinconf_groups_show':
drivers/pinctrl/pinconf.c:346:28: warning: unused variable 'ops' [-Wunused-variable]
  const struct pinconf_ops *ops = pctldev->desc->confops;
                            ^

Introduced by commit c420619d5177 ("pinctrl: pinconf: remove checks on
ops->pin_config_get").

Sorry, that I did not notice this earlier.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/8b250078/attachment.sig>
