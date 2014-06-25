From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jun 2014 20:07:37 +0200
Subject: [PATCH] clk: define and export __clk_get_debug for providers
In-Reply-To: <1403713591-17179-1-git-send-email-pdeschrijver@nvidia.com>
References: <1403713591-17179-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <44039675.8s16pHQIVH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 June 2014 19:26:31 Peter De Schrijver wrote:
> Define and export a new function __clk_get_debug which returns the debugfs
> directory entry pointer. This can be used by clock providers to add debugfs
> entries which are not related to a specific clock type. Examples include the
> ability to measure the rate of a clock. It can also be used by modules to
> create new debugfs entries. This is useful if you want to expose features
> for testing which can potentially cause system instability such as allowing
> to change a clock's rate from userspace.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 

Just an idea, but would it be better to add a pair of functions to add/remove
debugfs files rather than exposing the dentry itself?

	Arnd
