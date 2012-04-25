From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Apr 2012 09:01:57 -0600
Subject: Tag on pinctrl
In-Reply-To: <20120425104559.GA16752@sirena.org.uk>
References: <CACRpkdYqZrNFxj4kyMqYZk5PAcjF6-TroJ+Xq+3EVBLvo5Zg-Q@mail.gmail.com>
 <4F96D84E.7080204@wwwdotorg.org> <20120425104559.GA16752@sirena.org.uk>
Message-ID: <4F9811E5.4040105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 04:46 AM, Mark Brown wrote:
> On Tue, Apr 24, 2012 at 10:43:58AM -0600, Stephen Warren wrote:
> 
>> Yes, I have pulled that tag into the Tegra tree as
>> for-3.5/gpio-pinmux-dependency, and have a Tegra-specific
>> for-3.5/gpio-pinmux branch that depends on it. Two other Tegra branches
>> in turn (for-3.5/tegra30-audio, for-3.5/usb-ulpi) depend on
>> for-3.5/gpio-pinmux.
> 
>> Linus, I think this will get into the ARM SoC tree simply by my saying
>> in my for-3.5/gpio-pinmux pull request that the branch depends on your
>> tag; I don't /think/ you need to explicitly send a pull request there,
>> right?
> 
> If the gpio-pinmux branch is based on Linus' branch (which it really
> should be if it's a dependency...) then git will do the right thing
> here.  If it's not then you need to explicitly get things pulled in but
> there will also be bisection issues.

The Tegra branch is indeed based directly on the pinctrl branch.

However, I was talking more about how Arnd/Olof are managing arm-soc
than raw git operation; I believe they like to keep an explicit separate
branch for each dependency in order to track which commits to wait for
before sending pull requests for the branches they have that are based
on them, so the dependent commits come in from their original subsystem
first.
