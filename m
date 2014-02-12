From: cooloney@gmail.com (Bryan Wu)
Date: Wed, 12 Feb 2014 13:55:37 -0800
Subject: [PATCH 1/2] ARM: tegra: enable I2C Mux driver for PCA9546 in
 defconfig
In-Reply-To: <52FBD6C9.2010905@wwwdotorg.org>
References: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
 <52FBC6A9.7010401@wwwdotorg.org>
 <CAK5ve-+bzLkdwmab9sZGPk7p67ktVcK3mHQ2aUgMueH061ty6w@mail.gmail.com>
 <52FBD6C9.2010905@wwwdotorg.org>
Message-ID: <CAK5ve-+2AGO0UCf4UOMLoqGmQLp7QN08OJbZxUc-oYZzjPdFcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 12:17 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/12/2014 01:09 PM, Bryan Wu wrote:
>> On Wed, Feb 12, 2014 at 11:08 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 02/07/2014 04:54 PM, Bryan Wu wrote:
>>>> PCA9546 is used in Cardhu Tegra30 board to connect to 3 cameras.
>>>> Enabling this driver for Tegra V4L2 soc camera driver and camera
>>>> sensor drivers.
>>>
>>> I've squashed patch 1/2 into Tegra's for-3.15/defconfig branch, and
>>> applied patch 2/2 to Tegra's for-3.15/dt branch.
>>>
>>> Note that your patches were sent with an email "From" address that
>>> didn't match your signed-off-by tag, yet "git send-email" didn't insert
>>> a "From" header in the email body. Can you please check your git user ID
>>> and/or email settings. Consequently, I had to adjust the git author
>>> field in git to match your s-o-b line.
>>
>> My bad. I need to update my git send-email script to use --from "Bryan
>> Wu <pengw@nvidia.com>" instead of --from "Bryan Wu
>> <cooloney@gmail.com>"
>>
>> Need I resubmit this patchset?
>
> No need to resent; I fixed them up.
>
> Why not just put the correct values in ~/.gitconfig?
>
> Perhaps this is because you switch between NVIDIA and non-NVIDIA email
> addresses and/or mail servers, so you can't make ~/.gitconfig static and
> universally correct? If you have a recent enough git, what I do is:
>
> $ cat ~/.gitconfig
> [include]
>         path = .gitconfig-user
>         path = .gitconfig-email-server
> ...
>
> $ cat ~/.gitconfig-user-nvidia
> [user]
>         name = Stephen Warren
>         email = swarren at nvidia.com
>
> $ cat ~/.gitconfig-user-wwwdotorg
> [user]
>         name = Stephen Warren
>         email = swarren at wwwdotorg.org
>
> ~/.gitconfig-user is a symlink to one of ~/.gitconfig-user-*, and I have
> a script that deletes the link and points it at a new location:
>
> $ cat `which git-switch-user`
> #!/bin/bash
>
> cd $HOME
> mainfile=.gitconfig-user
> newlink=${mainfile}-$1
> if [ ! -f ${newlink} ]; then
>     echo ERROR: ${newlink} not found
>     exit 1
> fi
>
> rm -f ${mainfile}
> ln -s ${newlink} ${mainfile}
>
> ... and the same thing for email servers.
>
> Then, I can run e.g.:
>
> git-switch-email-server nvidia; \
> git send-email --to internal at nvidia.com *.patch; \
> git-switch-email-server severn-port-forwarded

Awesome, I will firstly update my .gitconfig. Actually I basically
just have one outbound server which is gmail server. Although I put
From: @nvidia.com, I still use gmail server to send out patch emails.
Still don't wanna touch our internal email server.

Thanks a lot and it's really helpful.
-Bryan
